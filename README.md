# Multi-pass Rendering for Water in GameMaker Games

Have you ever tried to implement water with shaders in GameMaker and couldn't get 
it to work? 

Well, AllFenom of #ZoriasGame did.  He showed up on [GameMaker Helpers discord](https://discord.gg/gamemaker-helpers-296278066223644683)
and could not get some water shaders to work.  We both tried and tried multiple shaders
until I realized exactly what was wrong.

In AllFenom's case, he was using the application_surface as a source, while drawing
to the application_surface -- you cannot do this! 

While trying to help him I went through a number of water tutorials and none of them made it very easy, 
or did what he was trying to do.  Some where interesting, so I will share them here:

* This was the one he originally tried: GameMaker tutorial Box, Underwater EFfect https://www.youtube.com/watch?v=U3ikTQzaDjg

* Sara Spalding Water Shader & Physics, https://www.youtube.com/watch?v=gMR3fypXHiY
 
* https://github.com/LAGameStudio/gml-pro I even tried a shader I wrote called Ripple

* Dragonite's Flowing Water Shaders, on which this was based, had a clean simple shader but a few issues and it did not work out of the box nor explain how to make it work beyond the techniques of rendering

So, most likely you are going to want to use this shader in a game, not in a demo or test case!  To do so you have to do some things, which I have outlined for you in the sample project.

# How it works

You have to draw the world _before_ the water distortion on a surface that is the same size as the room or 
application_surface, but is not the application_surface.

This becomes an input source image to the shader included.

The second surface you have to create is a masking surface.  
This surface is filled with black, then white pixels are drawn 
to it indicating where you want the distortion to occur.  
It is possible to mix the two with grey values (it only samples 
the RED values by the way, you could encode other things into 
the BLUE and GREEN channels, for instance to mix other effects
in or whatever, where red = distort, blue = bloom, green = pixelate,
just as an example)

Once you have those two surfaces, the "basic world" (which contains everything without the effect) and the "distortion mask", you can call the shader, provide it the time value and the two input textures, and it will distort the areas indicated by the rectangles.

You should capture that onto either a "final" surface, and draw that surface to the screen/application_surface, or you can attempt to just draw the shader output to the screen if you want to save that step, but it can be useful to have that on a final surface if you want to, for example, fade it in and out, or stretch it and shrink it (or another shader you use for transitions).

Anyway, download the .yyz or the whole project and give it a go!

# To Integrate

You will need to use a PreDraw to maintain and set the target surface,
all of your sprites and tiles etc can then draw normally, then you will
need a PostDraw to take the captured world, reset the surface,
maintain/target the water distortion mask surface, clear it with black, 
then go through your water regions and draw them to the surface (if you 
haven't already).  Then, use the shader to fill the final surface
or app surface directly.

# Based on Dragonite's Flowing Water Shaders, original readme below

Did you ever look at a Nintendo game and say "wow, that game sure has nice water?" 

Here's how you can implement one of the tricks they use for yourself in GameMaker!

Video tutorial:

[![YouTube](https://i.ytimg.com/vi/hNF62O0D308/hqdefault.jpg)](https://youtu.be/hNF62O0D308)
