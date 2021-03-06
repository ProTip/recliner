Recliner
========
Recliner is a couchbase management gem and a cluster node converger.  The joiners can be run externally for testing, but they are designed to work independently on each node as well.

Converging
==========
## Concept
Converging new clusters leverages two main concepts:
###Soft joining
Couchbase nodes are 'soft-joined' to existing clusters.  That is, the cluster does not start shifting keys until you 'commit' pending changes via a rebalance.  This allows us to let nodes migrate between clusters and then analyse the results without causing damage.
###Cluster Preference
Nodes have a preference of cluster.  They will prefer to be in "Top" cluster.  The top cluster is the largest, first member list string-sorted cluster(clusters are sorted by member size, then the list of members as a string).  This ensures all nodes converge on the same cluster.
## Process
* Create a list of clusters by polling member list for details.
* Create a new cluster if one does not exist.
* Choose the top cluster from this list.
* Join this cluster if not already in it.
* Determine if the cluster is converged(all nodes are in the top cluster).
* Rinse and repeat.
* 
Example
=======

```ruby
require 'recliner'

members = %w(192.168.1.20 192.168.1.21 192.168.1.22 192.168.1.23)

members.each do |member|
  joiners << Recliner::ClusterJoiner.new( 
  :hostname => member,
  :members => members - [member], 
  :username => 'Administrator', 
  :password => 'Password')
end

def converge(joiners)
  converged = Array.new(joiners.count, false)
  while converged.include?(false)
    puts 'Running joins...'
    joiners.each.with_index do |joiner, i|
      joiner.join
      converged[i] = joiner.converged?
    end
    sleep 4
  end
  puts 'Converged!'
end
```


