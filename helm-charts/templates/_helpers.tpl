{{/*
Expand the name of the chart.
*/}}
{{- define "onlineboutique.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "onlineboutique.fullname" -}}
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
Common labels
*/}}
{{- define "onlineboutique.labels" -}}
helm.sh/chart: {{ include "onlineboutique.name" . }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "onlineboutique.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Pod security context from kubernetes-manifests.yaml
*/}}
{{- define "onlineboutique.podSecurityContext" -}}
{{- if .Values.securityContext.enable }}
securityContext:
  fsGroup: 1000
  runAsGroup: 1000
  runAsNonRoot: true
  runAsUser: 1000
{{- end }}
{{- end }}

{{/*
Container security context from kubernetes-manifests.yaml
*/}}
{{- define "onlineboutique.containerSecurityContext" -}}
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
  privileged: false
  readOnlyRootFilesystem: true
{{- end }}

{{/*
Image reference for microservices
*/}}
{{- define "onlineboutique.image" -}}
{{- $tag := (.Values.images.tag | default .Chart.AppVersion) -}}
{{- if .Values.images.singleRepository -}}
{{- printf "%s:%s-%s" .Values.images.repository .imageName $tag -}}
{{- else -}}
{{- printf "%s/%s:%s" .Values.images.repository .imageName $tag -}}
{{- end -}}
{{- end }}

{{/*
Service account name
*/}}
{{- define "onlineboutique.serviceAccountName" -}}
{{- if .Values.serviceAccounts.create -}}
{{ .serviceName }}
{{- else -}}
default
{{- end -}}
{{- end }}
