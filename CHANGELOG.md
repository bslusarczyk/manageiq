# Change Log

All notable changes to this project will be documented in this file.

## Unreleased - as of Sprint 16 end 2014-12-02

### [Added](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+16+Ending+Dec+2%2C+2014%22+label%3Aenhancement)

- Rest API
  - Added support for accounts sub-collection /api/vms/#/accounts
  - Added support for software sub-collection /api/vms/#/software
- Providers: Amazon Events
  - Enables event-based policies for AWS
- UI: Continued work on supporting I18N
- IPv6 support
  - VMware communication (complete)
  - RHEVM/oVirt communication (in progress)
  
### [Changed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+16+Ending+Dec+2%2C+2014%22+label%3Aenhancement)

- UI: jqPlot, default charts, chart styling
- Cloud Orchestration: Modeling complete
- Services
  - Dialog seeding for imports
  - Service provisioning request overrides
- Automate Enhancements
  - Specify zone for web service automation request
  - Request message override
- LDAP
  - Allow undefined users to log in when “Get User Groups from LDAP” is disabled
  - Ability to set default group for LDAP Authentication

### [Removed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+16+Ending+Dec+2%2C+2014%22+label%3A%22technical+debt%22)

- SmartProxy (host) directory
- Rails Fork removal
  - Backport disable_ddl_transaction! from Rails master to our fork
  - Update the main app to use disable_ddl_transaction!
  - Add bigserial support for primary keys to Rails (including table creation and FK column creation)
  - Backport bigserial API to our fork
  - Update application to use new API

### [Fixed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+16+Ending+Dec+2%2C+2014%22+label%3Abug)

- 44 issues fixed. 
- Notable fixes include:
  - Fixed issue where deleting a cluster or host tries to delete all policy_events, thus never completing when there are millions of events.
  - Fixed inheriting tags from resource pool.
  - Fixed openstack provisioning to deal with multiple security groups with the same name.
  - Fixed seeding of VmdbDatabase timing out with millions of vmdb_metrics rows

## Unreleased - as of Sprint 15 end 2014-11-10

### [Added](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+15+Ending+Nov+10%2C+2014%22+label%3Aenhancement)

- Security: Lock down [POODLE](http://en.wikipedia.org/wiki/POODLE) attacks.
- Ruby 2.0
  - Appliance now built using Ruby 2.0
  - New commits and pull requests - tested with Ruby 2.0
- Service Dialogs: Exports can be copied onto an appliance and seeded during appliance startup
- UI: Continued work on supporting I18N.
   
### [Changed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+15+Ending+Nov+10%2C+2014%22+label%3Aenhancement)

- Security
  - Command tool fix_auth now can update passwords in database.yml
  - Better messaging around overwriting database encryption keys (aka v2_key)
- More Rails patches removed/upstreamed/backported
  - Bigint id columns
  - Memoist gem replaced deprecated ActiveSupport::Memoizable
- UI: Replaced many legacy Prototype calls with jQuery equivalents.
- Upgraded AWS SDK gem
- Upgraded Fog gem

### [Removed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+15+Ending+Nov+10%2C+2014%22+label%3A%22technical+debt%22)

- Old C-Language VixDiskLib binding code
- Code from product that has been upstreamed into Rails.
- Testing: Removed have_same_elements custom matcher in favor of built-in match_array

### [Fixed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+15+Ending+Nov+10%2C+2014%22+label%3Abug)

- 45 issues closed.

## Unreleased - as of Sprint 14 end 2014-10-20

### [Added](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+14+Ending+Oct+20%2C+2014%22+is%3Aclosed+label%3Aenhancement)

- Support SSL for OpenStack
  - Deals with different ways to configure SSL for OpenStack
    - SSL termination at OpenStack services
    - SSL termination at proxy
    - Doesn’t always change the service ports
  - Attempts non-SSL first, then fails over to SSL
- Model Template many-to-many Cloud Tenant
- Support Version 5 XFS filesystem
- Allow Automate methods to override or extend parameters passed to provider by
  updating the clone_options during provisioning

### [Changed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+14+Ending+Oct+20%2C+2014%22+is%3Aclosed+label%3Aenhancement)

- Updated report listviews to use glyphicons
- Chart Themes
- Allow Default Zone description to be changed   

### [Removed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+14+Ending+Oct+20%2C+2014%22+is%3Aclosed+label%3A%22technical+debt%22)

- Graphical summary screens
- VDI support
- Various monkey patches to prepare for Ruby 2 and Rails 4 upgrades  

### [Fixed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+14+Ending+Oct+20%2C+2014%22+is%3Aclosed+label%3Abug)

- 42 issues closed.

## Unreleased - as of Sprint 13 end 2014-09-29

### [Added](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+13+Ending+Sept+29%2C+2014%22+is%3Aclosed+label%3Aenhancement)

- UI
  - OpenStack: Tenant relationships added to summary screens.
  - Cloud images and instances: Added root device type to summary screens.
  - Cloud flavors: Added block storage restriction to summary screens.
  - Cleaned up Service Requests list and detail views.
  - Added cloud models to reporting.
- Automate
  - Added new service model for CloudResourceQuota and exposed relationships
    through EmsCloud and CloudTenant models.
  - Enhanced import to allow granularity down to the namespace.
- Provisioning
  - OpenStack: Added tenant filtering on security groups, floating IPs, and
    networks.
  - Amazon: added filtering of flavors based on root device type and block
    storage restrictions.
- Providers
  - All: Added collection of raw power state and exposed to reporting.
  - Cloud: Added a backend attribute to identify public images.
  - OpenStack: Added support for non-admin users to EMS Refresh.
- Fleecing
  - Added XFS filesystem support.
- Security
  - Added Kerberos ticket based SSO to web UI login.
- Appliance
  - Added a rake task to allow a user to replicate all pending backlog before
    upgrading.
  - Appliance Console: Added ability to copy keys across appliances.

### [Fixed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+13+Ending+Sept+29%2C+2014%22+is%3Aclosed+label%3Abug)

- 80 issues fixed.  Notable fixes include
  - UI: Fixed RBAC / Feature bugs
  - OpenStack provider will gracefully handle 404 errors.
  - server_monitor_poll default setting changed to 5 seconds.  This should
    result in shorter queue wait times across the board.
  - Fixed issue where deleting an EMS and adding it back would cause failure to
    refresh.
  - Fixed issue where a stopped or paused OpenStack instance could not be
    restarted.
  - More Ruby 2.0 backward compatible fixes.

## Unreleased - as of Sprint 12 end 2014-09-09

### [Added](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+12+Ending+Sept+9%2C+2014%22+is%3Aclosed+label%3Aenhancement)

- Automate
  - Exposed cloud relationships in automate service models.
  - Persist state data through automate state machine retries.
  - Moved auto-placement into an Automate state-machine step for Cloud and
    Infrastructure provisioning.
  - Added common "Finished" step to all Automate state machine classes.
  - Added eligible_* and set_* methods for cloud resources to provision task
    service model.
- EMS Refresh / Provisioning
  - Amazon EC2 virtualization type collected during EMS refresh for better
    filtering of available types during provisioning.
- UI
  - UI updates to form buttons with Patternfly.
- REST API
  - Support for external authentication (httpd) against an IPA server.
- Appliance
  - Ability to configure a temp disk for OpenStack fleecing added to the
    appliance console.
  - Generation of encryption keys added to the appliance console and CLI.
  - Generation of PostgreSQL certificates, leveraging IPA, added to the
    appliance console CLI.
  - Support for Certmonger/IPA to the appliance certificate authority.
- Other
  - EVM dump tool enhanced.
  - A change log!

### [Fixed](https://github.com/ManageIQ/manageiq/issues?q=milestone%3A%22Sprint+12+Ending+Sept+9%2C+2014%22+is%3Aclosed+label%3Abug)

- 63 issues fixed.  Notable fixes include
  - Fixed appliance logrotate not actually rotating the logs.
  - Some Ruby 2.0 backward compatible fixes.
  - Gem upgrades for bugs/enhancements
    - haml
    - net-ldap
    - net-ping
