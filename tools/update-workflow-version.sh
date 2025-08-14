#!/bin/bash -e

# This script updates the workflow file in the parent git repository to
# match the submodule versios.
SUBMODULE_ROOT=$(cd "$(dirname "$0")" && git rev-parse --show-toplevel)
REPO_ROOT=$(cd "${SUBMODULE_ROOT}" && git rev-parse --show-superproject-working-tree)

# For MacOS and Linux compatibility, see comment in setup-project-repo.sh
SED_BACKUP_EXT=.pcb-workflows-backup

# Update SHA in dispatcher
SUBMODULE_SHA=$(git --git-dir "$SUBMODULE_ROOT/.git" rev-parse HEAD)
sed -i"$SED_BACKUP_EXT" "s/dispatcher.yml@.*/dispatcher.yml@$SUBMODULE_SHA/" "$REPO_ROOT/.github/workflows/workflow.yml"
rm "$REPO_ROOT/.github/workflows/workflow.yml$SED_BACKUP_EXT"
