{{/*
Expand the name of the chart.
*/}}
{{- define "my-python-appulan-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default name using the release name.
*/}}
{{- define "my-python-appulan-chart.name" -}}
{{- .Release.Name -}}
{{- end -}}
