#!/bin/bash
# =============================================================================
# Script: download_aba_genomes.sh
# Descripción: Descarga automatizada de genomas de Acinetobacter baumannii
#              de Latinoamérica para validación de modelos predictivos.
# Autor: Basado en la recopilación de accesos verificados
# Versión: 1.1 (Corregido para NCBI Datasets CLI v16+)
# =============================================================================

set -euo pipefail

# =============================================================================
# 1. CONFIGURACIÓN Y DEPENDENCIAS
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/download_aba_genomes_$(date +%Y%m%d_%H%M%S).log"
DOWNLOAD_DIR="${SCRIPT_DIR}/genomes"
mkdir -p "${DOWNLOAD_DIR}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# =============================================================================
# 2. FUNCIONES AUXILIARES
# =============================================================================

log_info() { echo -e "${GREEN}[INFO]${NC} $1" | tee -a "${LOG_FILE}"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "${LOG_FILE}"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" | tee -a "${LOG_FILE}"; }

log_section() {
    echo -e "\n${BLUE}========================================${NC}" | tee -a "${LOG_FILE}"
    echo -e "${BLUE}$1${NC}" | tee -a "${LOG_FILE}"
    echo -e "${BLUE}========================================${NC}\n" | tee -a "${LOG_FILE}"
}

check_dependencies() {
    log_section "VERIFICANDO DEPENDENCIAS"
    local missing_deps=()
    
    if ! command -v datasets &> /dev/null; then
        log_error "La herramienta 'datasets' no está instalada."
        missing_deps+=("datasets")
    else
        log_info "✓ 'datasets' encontrado"
    fi
    
    if ! command -v curl &> /dev/null; then
        missing_deps+=("curl")
    else
        log_info "✓ 'curl' encontrado"
    fi

    if ! command -v unzip &> /dev/null; then
        missing_deps+=("unzip")
    else
        log_info "✓ 'unzip' encontrado"
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Dependencias faltantes: ${missing_deps[*]}"
        exit 1
    fi
}

# =============================================================================
# 3. FUNCIONES DE DESCARGA CORREGIDAS
# =============================================================================

download_argentina() {
    log_section "DESCARGANDO GENOMAS DE ARGENTINA (3 cepas)"
    cd "${DOWNLOAD_DIR}"
    
    local arg_genomes="NXGW00000000.1,PGTR00000000.1,NTFR00000000.1"
    
    log_info "Descargando genomas de Argentina..."
    if datasets download genome accession ${arg_genomes} --filename "argentina_genomes.zip" 2>&1 | tee -a "${LOG_FILE}"; then
        unzip -o -q "argentina_genomes.zip" -d "argentina"
        log_info "✓ Genomas de Argentina procesados."
    else
        log_error "✗ Falló la descarga de genomas de Argentina"
    fi
    cd "${SCRIPT_DIR}"
}

download_bolivia() {
    log_section "DESCARGANDO GENOMAS DE BOLIVIA (55 cepas)"
    cd "${DOWNLOAD_DIR}"
    
    log_info "Descargando conjunto WGS de Bolivia desde ENA..."
    if curl -L -s -o "bolivia_55.fasta.gz" "https://www.ebi.ac.uk/ena/browser/api/fasta/QXPJ01000000"; then
        log_info "✓ Genomas de Bolivia descargados exitosamente."
    else
        log_error "✗ Falló la descarga de genomas de Bolivia"
    fi
    cd "${SCRIPT_DIR}"
}

download_bioproject() {
    local bp_id="$1"
    local country_name="$2"
    local folder_name="$3"

    log_section "DESCARGANDO GENOMAS DE ${country_name^^} (${bp_id})"
    cd "${DOWNLOAD_DIR}"

    log_info "Descargando ${country_name} mediante BioProject ${bp_id}..."
    if datasets download genome bioproject "${bp_id}" --filename "${folder_name}.zip" 2>&1 | tee -a "${LOG_FILE}"; then
        unzip -o -q "${folder_name}.zip" -d "${folder_name}"
        log_info "✓ Genomas de ${country_name} descargados y extraídos."
    else
        log_error "✗ Falló la descarga de ${country_name} (${bp_id})"
    fi
    cd "${SCRIPT_DIR}"
}

# =============================================================================
# 4. EJECUCIÓN PRINCIPAL
# =============================================================================

main() {
    log_section "INICIANDO PROCESO DE DESCARGA DE GENOMAS"
    check_dependencies
    
    # Descargas individuales / específicas
    download_argentina || true
    download_bolivia || true
    
    # Descargas por BioProject (Brasil, Paraguay, Perú, Chile)
    download_bioproject "PRJNA613847" "Brasil" "brazil" || true
    download_bioproject "PRJNA1012735" "Paraguay" "paraguay" || true
    download_bioproject "PRJNA1339005" "Perú" "peru" || true
    download_bioproject "PRJNA731249" "Chile" "chile" || true
    
    log_section "PROCESO COMPLETADO"
    log_info "Revisa la carpeta: ${DOWNLOAD_DIR}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi                                     