{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mailhog.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mailhog.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mailhog.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name for the auth secret.
*/}}
{{- define "mailhog.authFileSecret" -}}
    {{- if .Values.auth.existingSecret -}}
        {{- .Values.auth.existingSecret -}}
    {{- else -}}
        {{- template "mailhog.fullname" . -}}-auth
    {{- end -}}
{{- end -}}

{{/*
Create the name for the outgoingSMTP configmap.
*/}}
{{- define "mailhog.outgoingSMTPFileConfigMap" -}}
    {{- if .Values.outgoingSMTP.existingSecret -}}
        {{- .Values.outgoingSMTP.existingSecret -}}
    {{- else -}}
        {{- template "mailhog.fullname" . -}}-outgoing-smtp
    {{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "mailhog.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "mailhog.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "mailhog" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}