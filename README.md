# BOSH release for k3s

**As of Jan 10, 2024, this repo is deprecated and replaced by granular repos.** See full details into https://github.com/orange-cloudfoundry/k3s-boshrelease/discussions/195 

This repo is only used to track issues for new feature requests that don't yet fit into existing granular repos and would require a new repo such as  https://github.com/orange-cloudfoundry/k3s-boshrelease/issues/86

<table border="0" CELLPADDING=”10″  WIDTH=”300p″ ALIGN=”CENTER”>
  <tr>
    <th><img src="https://k3s.io/img/k3s-logo-light.svg" height="100p" alt="k3s Logo" /></th>
    <th><img src="https://www.cloudfoundry.org/wp-content/uploads/2017/10/CFF-BOSH-Full-Color-1.png" height="100p" alt="Bosh Logo" /></th>
  </tr>
</table>


This BOSH release and deployment manifest deploy a cluster of k3s

Lightweight Kubernetes. 5 less than k8s. https://k3s.io.

The aim of the bosh release:
- offer a very thin layer on top of k3 binary
- reduced memory footprint wrt existing k8s bosh release

- enrich k3 experience with bosh goodies
  - reproductible / stable OS provided as stemcell
  - easy cluster deployment (multi-vm, multi-master, correcly wired master / agent)
  - multi-iaas capability (vpshere/openstack/gcp/azure/ ... )
  - credhub secrets generation (k3s-token)
- day 2 operations (persistend disk resize, stemcell rotation)  
- ease of dev / operations
  - k9s and kubectl are packaged and preconfigured inside the bosh instances
  - easy automation with complementary bosh mechanismes
    - bosh errand mechanism
    - helm-kubectl bosh release https://orange-cloudfoundry.github.io/helm-kubectl-boshrelease/
    - terraform bosh release https://github.com/orange-cloudfoundry/terraform-release
    - database bosh releases for backend (posgres / mysql /etcd)
    - generic scripting release (if low level scripting is required) https://github.com/orange-cloudfoundry/generic-scripting-release

## K3s compatibility matrix

Details about each embedded component are available at 
  https://www.suse.com/suse-k3s/support-matrix/all-supported-versions/k3s-v1-28/

## design overview

Provide a lightweight bosh packaging of Rancher k3s kubernetes distribution

Includes
- Rancher k3s binary
- k9S binary


The bosh release offers 2 jobs to build a full k3s bosh deployment:
- k3s-server job.
- k3s-agent job.


## Usage

This repository includes base manifests and operator files. They can be used for initial deployments and subsequently used for updating your deployments:

```plain
export BOSH_ENVIRONMENT=<bosh-alias>
export BOSH_DEPLOYMENT=k3s
git clone https://github.com/cloudfoundry-community/k3s-boshrelease.git
bosh deploy k3s-boshrelease/manifests/k3s.yml
```

If your BOSH does not have Credhub/Config Server, then remember `--vars-store` to allow generation of passwords and certificates.

### Update

When new versions of `k3s-boshrelease` are released the `manifests/k3s.yml` file will be updated. This means you can easily `git pull` and `bosh deploy` to upgrade.

```plain
export BOSH_ENVIRONMENT=<bosh-alias>
export BOSH_DEPLOYMENT=k3s
cd k3s-boshrelease
git pull
cd -
bosh deploy k3s-boshrelease/manifests/k3s.yml
```

## Full fledge usage sample
this bosh release usage can be seen in action in https://github.com/orange-cloudfoundry/paas-templates/tree/manual-drop/shared-operators/k3s

