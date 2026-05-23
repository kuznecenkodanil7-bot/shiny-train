package dev.raymond.bsodoverlay;

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;
import net.fabricmc.fabric.api.client.keybinding.v1.KeyBindingHelper;
import net.minecraft.client.MinecraftClient;
import net.minecraft.client.option.KeyBinding;
import net.minecraft.client.util.InputUtil;
import net.minecraft.util.Identifier;
import org.lwjgl.glfw.GLFW;

public final class BsodOverlayClient implements ClientModInitializer {
    public static final String MOD_ID = "bsod_overlay";

    private static final KeyBinding.Category CATEGORY = KeyBinding.Category.create(
            Identifier.of(MOD_ID, "main")
    );

    private static KeyBinding showBsodKey;
    private static KeyBinding hideBsodKey;

    @Override
    public void onInitializeClient() {
        showBsodKey = KeyBindingHelper.registerKeyBinding(new KeyBinding(
                "key.bsod_overlay.show",
                InputUtil.Type.KEYSYM,
                GLFW.GLFW_KEY_E,
                CATEGORY
        ));

        hideBsodKey = KeyBindingHelper.registerKeyBinding(new KeyBinding(
                "key.bsod_overlay.hide",
                InputUtil.Type.KEYSYM,
                GLFW.GLFW_KEY_0,
                CATEGORY
        ));

        ClientTickEvents.END_CLIENT_TICK.register(BsodOverlayClient::handleKeys);
    }

    private static void handleKeys(MinecraftClient client) {
        while (showBsodKey.wasPressed()) {
            client.setScreen(new BsodScreen());
        }

        while (hideBsodKey.wasPressed()) {
            if (client.currentScreen instanceof BsodScreen) {
                client.setScreen(null);
            }
        }
    }
}
