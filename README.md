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
