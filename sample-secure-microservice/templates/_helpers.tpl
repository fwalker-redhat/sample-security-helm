{{/*
Expand the name of the chart.
*/}}
{{- define "sample-secure-microservice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sample-secure-microservice.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sample-secure-microservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sample-secure-microservice.labels" -}}
helm.sh/chart: {{ include "sample-secure-microservice.chart" . }}
{{ include "sample-secure-microservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sample-secure-microservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sample-secure-microservice.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ .Release.Name }}
version: {{ .Chart.AppVersion }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sample-secure-microservice.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sample-secure-microservice.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "image-release-prefix" -}}
{{- if .Values.extConfig.security.oauth.enabled }}oidcsecurity
{{- else if .Values.extConfig.security.basic.enabled }}basicsecurity
{{- else }}nosecurity
{{- end }}
{{- end }}