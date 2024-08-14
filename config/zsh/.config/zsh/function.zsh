#!/usr/bin/env zsh

RED='\033[0;32m'
NC='\033[0m' # No Color

# Utility functions
functions command_exists() {
  command -v "$@" >/dev/null 2>&1
}

functions reload() {
    if [ -f  $HOME/.zshenv ]; then
        source $HOME/.zshrc
        clear
    fi
}

function kubectl_exec_sh() {
    local containers
    local container
    kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\n"}' | fzf | read -r namespace pod
    containers=$(kubectl get pod -n $namespace $pod -o jsonpath='{.spec.containers[*].name}')
    container=$(echo ${containers/ /\\n} | fzf)
    kubectl exec -n $namespace --stdin --tty $pod --container $containers -- /bin/sh
}

function kubectl_exec_bash() {
    local containers
    local container
    kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\n"}' | fzf | read -r namespace pod
    containers=$(kubectl get pod -n $namespace $pod -o jsonpath='{.spec.containers[*].name}')
    container=$(echo ${containers/ /\\n} | fzf)
    kubectl exec -n $namespace --stdin --tty $pod --container $container -- /bin/bash
}

function idea() {
    read -r pid < <(snap run intellij-idea-ultimate $@ 2>&1 &)
}
