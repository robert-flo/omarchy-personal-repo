#!/usr/bin/env bash
# Reporte estandar de fallos (ver action.yml). Idempotente; nunca falla el job.
set -uo pipefail
label="ci-failure:${CI_WORKFLOW}"
title="CI falla: ${CI_WORKFLOW}"
gh label create "$label" --color B60205 --description "Fallo abierto del workflow ${CI_WORKFLOW}" >/dev/null 2>&1 || true
n="$(gh issue list --state open --label "$label" --json number,title \
      --jq "map(select(.title == \"$title\"))[0].number // empty")"
err="${CI_ERROR:-sin detalle; ver el log del run}"
case "$CI_STATUS" in
  failure)
    body="$(printf 'Run: %s\n\nError:\n```\n%s\n```' "$CI_RUN" "$(printf '%s' "$err" | tail -c 3000)")"
    if [[ -n "$n" ]]; then gh issue comment "$n" --body "Falló otra vez. $body" && echo "ci-report: comentado #$n"
    else gh issue create --title "$title" --label "$label" \
        --body "$(printf 'El workflow **%s** falló. Se cerrará solo en el próximo run verde.\n\n%s' "$CI_WORKFLOW" "$body")" && echo "ci-report: issue creado"
    fi ;;
  success)
    if [[ -n "$n" ]]; then gh issue close "$n" --comment "Resuelto: run verde $CI_RUN" && echo "ci-report: cerrado #$n"
    else echo "ci-report: sin issue abierto"; fi ;;
  *) echo "ci-report: status desconocido '$CI_STATUS' (se ignora)";;
esac
exit 0
