shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float health : hint_range(0.0, 100.0) = 100.0;
uniform float blur_strength : hint_range(0.0, 8.0) = 2.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    float intensity = (1.0 - health / 100.0) * blur_strength;
    vec2 px = SCREEN_PIXEL_SIZE;
    vec4 sum = vec4(0.0);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2(-1.0, -1.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2( 0.0, -1.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2( 1.0, -1.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2(-1.0,  0.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2( 0.0,  0.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2( 1.0,  0.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2(-1.0,  1.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2( 0.0,  1.0) * intensity);
    sum += texture(SCREEN_TEXTURE, uv + px * vec2( 1.0,  1.0) * intensity);
    vec4 blurcol = sum / 9.0;
    float gray = dot(blurcol.rgb, vec3(0.299, 0.587, 0.114));
    float factor = 1.0 - (health / 100.0);
    vec3 final_color = mix(texture(SCREEN_TEXTURE, uv).rgb, vec3(gray), factor);
    COLOR = vec4(final_color, 1.0);
}
