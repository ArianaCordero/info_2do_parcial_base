shader_type canvas_item;

uniform vec4 glow_color = vec4(1.0, 0.95, 0.6, 1.0);

uniform float glow_size = 12.0;                       // tamaño del halo en px (aprox)

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = tex;
    if (tex.a < 0.01) {
        float g = 0.0;
        vec2 px = TEXTURE_PIXEL_SIZE * glow_size;

        g += texture(TEXTURE, UV + vec2( px.x,  0.0)).a;
        g += texture(TEXTURE, UV + vec2(-px.x,  0.0)).a;
        g += texture(TEXTURE, UV + vec2( 0.0,  px.y)).a;
        g += texture(TEXTURE, UV + vec2( 0.0, -px.y)).a;
        g += texture(TEXTURE, UV + vec2( px.x,  px.y)).a;
        g += texture(TEXTURE, UV + vec2( px.x, -px.y)).a;
        g += texture(TEXTURE, UV + vec2(-px.x,  px.y)).a;
        g += texture(TEXTURE, UV + vec2(-px.x, -px.y)).a;

        g /= 8.0;
        vec3 mixed = mix(COLOR.rgb, glow_color.rgb, g);
        COLOR = vec4(mixed, max(COLOR.a, g * glow_color.a));
    }
}
