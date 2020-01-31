# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
docs_dir = doc
ghdocs:
 rm -rf $(docs_dir)
 $(MAKE) clean
 $(MAKE) html
 cp -r build/html $(docs_dir)
 mv $(docs_dir)/_static $(docs_dir)/static
 mv $(docs_dir)/_sources $(docs_dir)/sources
 perl -pi -e "s/_sources/sources/g;" $(docs_dir)/*.html
 perl -pi -e "s/_static/static/g;" $(docs_dir)/*.html
 git add .
 git commit -a -m "Updates $(project)."
 git checkout gh-pages
 cp -rf $(docs_dir)/* .
 git add .
 git commit -a -m 'Updates $(project) documentation.'
 git checkout master
 rm -rf $(docs_dir)
 git push origin gh-pages
