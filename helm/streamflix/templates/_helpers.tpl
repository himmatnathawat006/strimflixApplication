{{/*
================================================================================
StreamFlix Helper Functions (_helpers.tpl)
================================================================================
Defines helper template blocks for reusable variables, labels, and naming
conventions across the Kubernetes templates.
================================================================================
*/}}

{{/*
Helper: Expand the name of the chart.
Resolves to the chart name or values-level nameOverride.
*/}}
{{- define "streamflix.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Helper: Create a default fully qualified app name.
Uses Release name + Chart name or fullnameOverride. Truncates to 63 chars (DNS specs).
*/}}
{{- define "streamflix.fullname" -}}
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
Helper: Create chart name and version as used by the chart label.
Format: name-version (e.g. streamflix-0.1.0)
*/}}
{{- define "streamflix.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Helper: Common/Standard Kubernetes Labels
Injected into the metadata block of all Kubernetes resources.
*/}}
{{- define "streamflix.labels" -}}
helm.sh/chart: {{ include "streamflix.chart" . }}
{{ include "streamflix.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Helper: Selector Labels
Injected into service selectors and deployment template pod selectors.
*/}}
{{- define "streamflix.selectorLabels" -}}
app.kubernetes.io/name: {{ include "streamflix.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
