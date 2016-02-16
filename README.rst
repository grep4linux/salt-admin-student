====================================================
Student Setup of Fundamentals of Salt Administration
====================================================

SaltStack Training Services
===========================

This project is to duplicate the student environment used in the SaltStack Fundamentals of Salt Administration course so that labs can be practiced after the course.

There are a couple of differences from the setup during the class. For example, the vagrant project installs the Salt master and all minions so you can skip the first lab. Also, the Salt cloud configuration is not implemented since all VMs are running local. The ``sdev`` system is running CentOS and not SUSE.

Requirements
============

* VirtualBox
* Vagrant
* Enough resources for 5 virtual machines (~ 3GB RAM)


Instructions
============

#. Install the required software listed above.
#. Clone the project to your local system.

    .. code-block:: bash

        git clone https://github.com/grep4linux/salt-admin-student

#. Change to the cloned directory where the Vagrantfile is located and run:

    .. code-block:: bash

        vagrant up

    Vagrant will build out the environment. It will take a few minutes for all systems to be built.

#. Once the build process completes you can view the status of the virtual machines by running:

   .. code-block:: bash

      vagrant status
      Current machine states:
      
      saltmaster                running (virtualbox)
      cweb                      running (virtualbox)
      redis                     running (virtualbox)
      uarchive                  running (virtualbox)
      sdev                      running (virtualbox)
      
      This environment represents multiple VMs. The VMs are all listed
      above with their current state. For more information about a specific
      VM, run `vagrant status NAME`.




#. You can login to the sytems through each VirtualBox console or you can log using vagrant. 

  #. To login to the saltmaster through VirtualBox then select that console and login as ``root`` with the password of ``vagrant``.

  #. To login to the saltmaster through Vagrant then type:

      .. code-block:: bash

        vagrant ssh saltmaster

#. The virtual machines change be suspended by running:

    .. code-block:: bash

      vagrant suspend 

#. The environment can be brought up again by running:

    .. code-block:: bash

      vagrant up

#. The entire environment can be destroyed and reset by running:

    .. code-block:: bash

      vagrant destroy -f

Notes
=====

Common edits to the ``Vagrantfile``.

#. If you want to run through the installation then place a comment ``#`` infront of each line containing ``saltify.sh``.

#. If you want a master of masters VM then duplicate the ``cweb`` section and replace ``cweb`` with ``mom`` and change the IP address to ``192.168.50.105``.

#. If you don't want the VirtualBox windows opened then replace each instance of ``vb.gui = true`` to ``vb.gui = false`` in the ``Vagrantfile``.

