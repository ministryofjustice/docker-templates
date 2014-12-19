import os

from fabric.api import env, task, local

from cotton.salt_shaker import Shaker


@task
def shaker():
    shaker = Shaker(root_dir=os.path.dirname(env.real_fabfile))
    shaker.install_requirements()


@task
def freeze():
    local('for d in vendor/formula-repos/*; do echo -n "$d "; git --git-dir=$d/.git describe --tags 2>/dev/null || git --git-dir=$d/.git rev-parse --short HEAD; done', shell='/bin/bash')


@task
def check():
    local('for d in vendor/formula-repos/*; do (export GIT_DIR=$d/.git; git fetch --tags -q 2>/dev/null; echo -n "$d: "; latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1 2>/dev/null) 2>/dev/null || echo "no tags"); current=$(git describe --tags 2>/dev/null || echo "no tags"); echo "latest: $latest_tag; current: $current"); done', shell='/bin/bash')
