base:

  '*':
    - bootstrap
    - supervisor
    - hosts
    - repos

  'roles:monitoring.server':
    - match: grain
    - monitoring.server
