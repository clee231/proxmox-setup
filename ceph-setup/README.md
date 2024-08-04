# Ceph Data Plane

This sets up a Ceph cluster across the nodes of the cluster.

We expect at least 3 nodes in the cluster.

## Run the playbook

```bash
ansible-playbook -i inventory.yml main.yml -K
```
