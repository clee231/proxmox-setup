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

## Some Troubleshooting

### OSD data directory is empty
If the OSD data directory is empty after a reboot, you may need to rebuild the monitor DB.

```bash
sudo ceph-volume lvm activate --all --no-systemd
sudo systemctl restart ceph-osd-<osd_id>
```

### ceph command not responding or timeout

If you are running ceph commands and they are not responding, see if you can communicate directly with the ceph daemons to get status.

For example, to communicate with the mon daemons:

```bash
sudo ceph daemon mon.ceph1 mon_status
```

### Getting the cluster health

To get the cluster health, run the following command:

```bash
sudo ceph health
```

For more specific details, run the following command:

```bash
sudo ceph health detail
```
