# This is an application deployed in OSSM to demonstrate equal loadbalancing between two application

The service mesh was deployed with following SMCP configuration.

~~~
$ oc get smcp basic -oyaml | yq .spec
{
  "addons": {
    "grafana": {
      "enabled": true
    },
    "jaeger": {},
    "kiali": {
      "enabled": true
    },
    "prometheus": {
      "enabled": true
    }
  },
  "gateways": {
    "openshiftRoute": {
      "enabled": false
    }
  },
  "policy": {
    "type": "Istiod"
  },
  "profiles": [
    "default"
  ],
  "telemetry": {
    "type": "Istiod"
  },
  "tracing": {
    "type": "None"
  },
  "version": "v2.5"
}

~~~

Configure the SMMR to include the required project.

~~~
$ oc get smmr default -oyaml | yq .spec
{
  "members": [
    "kuard"
  ]
}
~~~

Deploy the application by cloning the repository and you should be able to achive the required loadbalancing.

~~~
$ oc create -f kuard-blue.yaml
deployment.apps/kuard-blue created

$ oc create -f kuard-green.yaml
deployment.apps/kuard-green created

$ oc create -f svc.yaml 
service/kuard created

$ oc create -f kuard-gw.yaml 
gateway.networking.istio.io/kuard-gw created

$ oc create -f kuard-vs.yaml 
virtualservice.networking.istio.io/kuard-vs created

$ oc create -f destination-lb.yml 
destinationrule.networking.istio.io/kuard-dr created

$ oc get pods 
NAME                           READY   STATUS    RESTARTS   AGE
kuard-blue-57f79bd69b-hhdmb    2/2     Running   0          57s
kuard-green-76c979744b-5hgbg   2/2     Running   0          48s

$ oc create -f kuard-route.yaml 
route.route.openshift.io/kuard-gw created

~~~


