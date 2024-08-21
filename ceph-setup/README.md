# Ceph Data Plane

This sets up a Ceph cluster across the nodes of the cluster.

We expect at least 3 nodes in the cluster.

## Install Dependencies

```bash
ansible-galaxy install -r requirements.yml
```

## Run the playbook

```bash
ansible-playbook -i inventory.yml main.yml -K
```
