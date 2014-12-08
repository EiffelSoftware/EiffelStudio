#include "queue_cache.hpp"
#include "processor.hpp"

priv_queue* queue_cache::operator[] (processor * const supplier)
{
	unordered_map <processor*, queue_stack>::iterator found_it = queue_map.find (supplier);
	priv_queue *pq;
	if (found_it != queue_map.end()) {
		queue_stack &stack = found_it->second;
		if (stack.empty()) {
			stack.EMPLACE_BACK (supplier->new_priv_queue());
		}
		pq = stack.back();
	} else {
		const std::pair <unordered_map <processor*, queue_stack>::iterator, bool> &res =
			queue_map.EMPLACE (std::pair <processor*, queue_stack> (supplier, queue_stack ()));
		queue_stack &stack = res.first->second;
		stack.EMPLACE_BACK (supplier->new_priv_queue());
		pq = stack.back();
	}

	return pq;
}
