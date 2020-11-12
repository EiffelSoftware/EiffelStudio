# Eiffel Graph Library 


## Documentation

* [Master Thesis](doc/)   `Extending the Eiffel Library for Data Structures and Algorithms: EiffelBase`.

## Limitations

### Cycle Detection
Currently, the graph library cannot answer the queries has cycles for undirected multigraphs. 
For simple graphs, Euler’s formula can be applied which states that an undirected graph has cycles if |edges| > |nodes| − components. 
For multigraphs, this formula cannot be applied anymore since multi-edges are not considered to be graph cycles. 
To cover all possible multigraph scenarios, it would be necessary to check each graph component forcycles individually. 
This is not possible with the current implementation.

### Adjacency matrix graph has no multigraph support
The implementation that is based on an adjacency matrix does not support multigraphs.
Usually, adjacency matrices contain boolean values which refer to whether two nodes are
connected or not. In our implementation, the item is not a boolean value, but an EDGE
object which represents the connection. In case there is no connection between two nodes,
the item is void. With that approach, only simple graphs can be supported.

## Class hierarchy
A rather subtle issue is that UNDIRECTED GRAPH is a subtype of GRAPH. 
An algorithm operating on a directed graph could produce unexpected results if the actual argument is an undirected graph, 
containing edges that can be traversed in both directions.
For instance, an algorithm that detects graph cycles in a directed graph would find a cycle
in an undirected graph with just one single edge, because there is a connection from the
first node to the second and vice versa. In a directed graph, this is a cycle, in an undirected
graph, it is not.

## Edge traversal using GRAPH_ITERATION_CURSOR
Currently, the graph iteration cursor keeps only track of the visited nodes, but not of the visited
edges. With that approach, you can explore all nodes according to the selected strategy,
but the edges are not taken into account. Algorithms that operate on edges and need a
specific traversal strategy cannot work with the provided GRAPH_ITERATION_CURSOR implementation.


## Changelog

	Fixed contract violations at runtime.
	Complete Void Safety.
	Expanded types can be used for Labels.
	Added test cases.
	Added GRAPH_ITERATION_CURSOR external iteration cursor used by `across...loop...end' for Graphs.
