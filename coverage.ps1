# Script para ver cobertura de tests
# Uso: .\coverage.ps1

$csv = Import-Csv "target\site\jacoco\jacoco.csv"

# Calcular métricas
$lm = ($csv | Measure-Object -Property LINE_MISSED -Sum).Sum
$lc = ($csv | Measure-Object -Property LINE_COVERED -Sum).Sum
$lt = $lm + $lc
$lcov = [math]::Round(($lc / $lt) * 100, 2)

$bm = ($csv | Measure-Object -Property BRANCH_MISSED -Sum).Sum
$bc = ($csv | Measure-Object -Property BRANCH_COVERED -Sum).Sum
$bt = $bm + $bc
$bcov = [math]::Round(($bc / $bt) * 100, 2)

$im = ($csv | Measure-Object -Property INSTRUCTION_MISSED -Sum).Sum
$ic = ($csv | Measure-Object -Property INSTRUCTION_COVERED -Sum).Sum
$it = $im + $ic
$icov = [math]::Round(($ic / $it) * 100, 2)

# Mostrar resultados
Write-Host "`n========== COBERTURA DE TESTS ==========" -ForegroundColor Cyan
Write-Host "`nLINEAS:        $lcov% ($lc/$lt)" -ForegroundColor Green
Write-Host "BRANCHES:      $bcov% ($bc/$bt)" -ForegroundColor Green
Write-Host "INSTRUCCIONES: $icov% ($ic/$it)" -ForegroundColor Green
Write-Host "`n========================================`n" -ForegroundColor Cyan
