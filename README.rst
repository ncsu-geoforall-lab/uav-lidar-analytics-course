UAV/lidar Data Analytics
=========================

This is a repository for a course website and teaching materials.

For reference about the template the website style see:

* https://github.com/ncsu-geoforall-lab/course-website-template
* https://github.com/ncsu-geoforall-lab/geospatial-modeling-course

To learn about Git and GitHub, you can use:

* http://ncsu-geoforall-lab.github.io/git-and-github-workshop/


Requirements
------------

* Bash
* Python
* Pandoc when using rst files


How to use it
-------------

To build the pages, run ``./build.sh``. 
This will create directory ``build`` on the repository root level.
To preview the resulting website, open ``build/index.html``.

The pages are published online through GitHub Pages (``gh-pages``
branch). The build and publishing happens automatically using GitHub
Actions (defined in ``.github/workflows/`` directory). A Deploy key and a Secret
are set up for this repository so that the action can access the branch.

Authors
-------

Copyright 2015-2020 by

* Helena Mitasova, NCSU GeoForAll Lab
* Justyna Jeziorska, NCSU GeoForAll Lab and University of Wroclaw
* Vaclav Petras, NCSU GeoForAll Lab
* Anna Petrasova, NCSU GeoForAll Lab

Course developed at the Center for Geospatial Analytics
North Carolina State University:

* https://geospatial.ncsu.edu/

License and use
---------------

The course material is under CC BY-SA 4.0 license.

https://creativecommons.org/licenses/by-sa/4.0/

For the website style see:

https://github.com/ncsu-geoforall-lab/course-website-template

For information on lecture slides (presentations) see:

https://github.com/ncsu-geoforall-lab/lecture-slides-template
