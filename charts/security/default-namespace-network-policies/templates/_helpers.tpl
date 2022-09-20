{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "default-namespace-network-policies.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "default-namespace-network-policies.fullname" -}}
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
{{- define "default-namespace-network-policies.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "default-namespace-network-policies.labels" -}}
helm.sh/chart: {{ include "default-namespace-network-policies.chart" . }}
{{ include "default-namespace-network-policies.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "default-namespace-network-policies.selectorLabels" -}}
app.kubernetes.io/name: {{ include "default-namespace-network-policies.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "default-namespace-network-policies.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "default-namespace-network-policies.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Kubernetes API server address block for network policies
*/}}
{{- define "default-namespace-network-policies.APIServerAddress" -}}
{{- $APIServerEndpoints := (index (lookup "v1" "Endpoints" "default" "kubernetes").subsets 0) }}
{{- $APIServerServiceAddress := (print (lookup "v1" "Service" "default" "kubernetes").spec.clusterIP) }}
{{- $APIServerServicePort := (print (index (lookup "v1" "Service" "default" "kubernetes").spec.ports 0).port) }}
- to:
  {{- range $k, $v := $APIServerEndpoints.addresses }}
  - ipBlock:
      cidr: {{ $v.ip }}/32
  {{- end }}
  ports:
  {{- range $k, $v := $APIServerEndpoints.ports }}
  {{- if eq $v.name "https" }}
  - protocol: TCP
    port: {{ $v.port }}
  {{- end }}
  {{- end }}
- to:
  - ipBlock:
      cidr: {{ $APIServerServiceAddress }}/32
  ports:
  - protocol: TCP
    port: {{ $APIServerServicePort }}
{{- end }}

{{/*
Kubernetes DNS service address block for network policies
*/}}
{{- define "default-namespace-network-policies.KubeDNSAddress" -}}
{{- if (lookup "v1" "Service" "kube-system" "kube-dns") }}
{{- print (lookup "v1" "Service" "kube-system" "kube-dns").spec.clusterIP "/32" }}
{{- end }}
{{- if (lookup "v1" "Service" "kube-system" "coredns") }}
{{- print (lookup "v1" "Service" "kube-system" "coredns").spec.clusterIP "/32" }}
{{- end }}
{{- end }}
