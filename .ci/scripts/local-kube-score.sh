#!/bin/bash

helm template charts/* -f .ci/values-kube-score.yaml --no-hooks | kube-score score - \
    --ignore-test pod-networkpolicy \
    --ignore-test deployment-has-poddisruptionbudget \
    --ignore-test deployment-has-host-podantiaffinity \
    --ignore-test container-image-pull-policy \
    --ignore-test container-security-context \
    --enable-optional-test container-security-context-privileged \
    --enable-optional-test container-security-context-readonlyrootfilesystem
