package shader;

import flixel.system.FlxAssets.FlxShader;

/**
 * Shader that distorts the screen to fake a 3D cylinder like the one used in Five Nights at Freddy's.
 *
 * Original shader written by "The Concept Boy" on YouTube (https://www.youtube.com/watch?v=-Ah8vvXwv5Y&ab_channel=TheConceptBoy)
 *
 * Adjusted to work with HaxeFlixel by "A Crazy Town"
 *
 * Still a W.I.P! There are issues with scaling the window!
**/
class PanoramicDistortionShader extends FlxShader
{
    @:glFragmentSource('
    #pragma header

    void main()
    {
        vec2 coordinates;
        float pixelDistanceX;
        float pixelDistanceY;
        float offset;
        float dir;

        pixelDistanceX = distance(openfl_TextureCoordv.x, 0.5);
        pixelDistanceY = distance(openfl_TextureCoordv.y, 0.5);

        offset = (pixelDistanceX * 0.2) * pixelDistanceY;

        if (openfl_TextureCoordv.y <= 0.5)
            dir = 1.0;
        else
            dir = -1.0;

        coordinates = vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y + pixelDistanceX * (offset * 8.0 * dir));
        gl_FragColor = flixel_texture2D(bitmap, coordinates);
    }
    ')

    public function new()
    {
        super();
    }
}
