package shaders;

/**
 * Shader that distorts the screen to fake a 3D cylinder like the one used in "Five Nights at Freddy's".
 *
 * Ported to HaxeFlixel by "A Crazy Town" (https://github.com/ACrazyTown)
 * Original shader by "The Concept Boy" (https://www.youtube.com/watch?v=-Ah8vvXwv5Y)
**/
class PanoramaDistortionShader extends flixel.system.FlxAssets.FlxShader
{
    public var distortion(default, set):Float = 0.1;
    private function set_distortion(value:Float):Float
    {
        this.distortionLevel.value = [value];
        return value;
    }

    @:glFragmentSource('
    #pragma header

    uniform float distortionLevel;

    void main()
    {
        vec2 coordinates;
        float pixelDistanceX;
        float pixelDistanceY;
        float offset;
        float dir;

        pixelDistanceX = distance(openfl_TextureCoordv.x, 0.5);
        pixelDistanceY = distance(openfl_TextureCoordv.y, 0.5);

        offset = (pixelDistanceX * distortionLevel) * pixelDistanceY;

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
        
        distortion = 0.1;
    }
}
