import Foundation
import TSCBasic
import TuistCore
import TuistSupport
import XcodeGraph

public enum FocusTargetsGraphMappersError: FatalError, Equatable {
    case targetsNotFound([String])

    public var type: ErrorType {
        switch self {
        case .targetsNotFound:
            return .abort
        }
    }

    public var description: String {
        switch self {
        case let .targetsNotFound(targets):
            return "The following targets were not found: \(targets.joined(separator: ", ")). Please, make sure they exist."
        }
    }
}

/// `FocusTargetsGraphMappers` is used to filter out some targets and their dependencies and tests targets.
public final class FocusTargetsGraphMappers: GraphMapping {
    // When specified, if includedTargets is empty it will automatically include all targets in the test plan
    public let testPlan: String?
    /// The targets name to be kept as non prunable with their respective dependencies and tests targets
    public let includedTargets: Set<String>
    public let excludedTargets: Set<String>

    public init(
        testPlan: String? = nil,
        includedTargets: Set<String>,
        excludedTargets: Set<String> = []
    ) {
        self.testPlan = testPlan
        self.includedTargets = includedTargets
        self.excludedTargets = excludedTargets
    }

    public func map(graph: Graph, environment: MapperEnvironment) throws -> (Graph, [SideEffectDescriptor], MapperEnvironment) {
        let graphTraverser = GraphTraverser(graph: graph)
        var graph = graph
        let userSpecifiedSourceTargets = graphTraverser.filterIncludedTargets(
            basedOn: graphTraverser.allTargets(),
            testPlan: testPlan,
            includedTargets: includedTargets,
            excludedTargets: excludedTargets,
            excludingExternalTargets: true
        )

        let unavailableIncludedTargets = Set(includedTargets).subtracting(userSpecifiedSourceTargets.map(\.target.name))
        if !unavailableIncludedTargets.isEmpty {
            throw FocusTargetsGraphMappersError.targetsNotFound(Array(unavailableIncludedTargets))
        }

        let filteredTargets = Set(try topologicalSort(
            Array(userSpecifiedSourceTargets),
            successors: { Array(graphTraverser.directTargetDependencies(path: $0.path, name: $0.target.name)).map(\.graphTarget) }
        ))

        graph.projects = graph.projects.mapValues { project in
            var project = project
            project.targets = project.targets.mapValues { target in
                var target = target
                if !filteredTargets.contains(GraphTarget(path: project.path, target: target, project: project)) {
                    target.prune = true
                }
                return target
            }

            return project
        }

        return (graph, [], environment)
    }
}
