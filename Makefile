Main: Main.hs Application.hs Routes.hs MustacheTemplates.hs PathHelpers.hs
	ghc -threaded -O2 -Wall -fno-warn-name-shadowing Main.hs

Routes.hs: routes
	routeGenerator -r -m Application -n 1 $< > $@

PathHelpers.hs: routes
	routeGenerator -p -n 1 $< > $@

MustacheTemplates.hs: Records.hs view/kwsoda.mustache view/ripple.mustache
	mustache2hs -m Records.hs view/kwsoda.mustache SodaView view/ripple.mustache RippleView > $@

clean:
	find -name '*.o' -o -name '*.hi' | xargs $(RM)
	$(RM) -r dist dist-ghc Main Routes.hs PathHelpers.hs MustacheTemplates.hs
