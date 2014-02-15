registerimg
===========

Utilities to create linux boot images to automatically register new hardware
nodes or update existing profiles. These images should be small in size
(ideally just a kernel and ramdisk) and should work using a number of different
media, particiularly usb, cdrom, and dhcp/bootp. 

This will be a set of utilities to create images that will automatically
register new hardware in a database, or with a management system like cobbler
or openstack baremetal. It will also provide some machine initialization
functionality.

Initial support will include reporting basic information, including number of
CPUs and architecture, amount of main memory, hard disk information, and
network information (particularly ethernet mac addresses), and initializing the
system hardware clock using ntp. Additional data sources and initialization
steps will be supported through a plug-in architecture. An early target is to
support gathering IMPI information and setting IMPI account names and passwords.

Various back ends will be supported on the back-end, with early targets being
mysql, mongodb, and running arbitrary scripts via ssh/gsissh login using
an unencrypted private key or temporary proxy certificate.

