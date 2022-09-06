#/bin/bash

# deploy skywalking backend, ui
git clone https://github.com/apache/skywalking-kubernetes.git
cd skywalking-kubernetes
cd chart
helm dep up skywalking
helm -n istio-system install skywalking skywalking \
  --set fullnameOverride=skywalking \
  --set elasticsearch.minimumMasterNodes=1 \
  --set elasticsearch.imageTag=7.5.1 \
  --set oap.replicas=1 \
  --set ui.image.repository=apache/skywalking-ui \
  --set ui.image.tag=9.2.0 \
  --set oap.image.tag=9.2.0 \
  --set oap.envoy.als.enabled=true \
  --set oap.image.repository=apache/skywalking-oap-server \
  --set oap.storageType=elasticsearch \
  --set oap.env.SW_METER_ANALYZER_ACTIVE_FILES='network-profiling'
