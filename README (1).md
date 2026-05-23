package dev.raymond.bsodoverlay;

import net.minecraft.client.MinecraftClient;
import net.minecraft.client.gui.DrawContext;
import net.minecraft.client.gui.screen.Screen;
import net.minecraft.client.input.KeyInput;
import net.minecraft.text.Text;
import org.lwjgl.glfw.GLFW;

public final class BsodScreen extends Screen {
    private static final int BSOD_BLUE = 0xFF0078D7;
    private static final int WHITE = 0xFFFFFFFF;

    public BsodScreen() {
        super(Text.literal("Fake BSOD"));
    }

    @Override
    public void render(DrawContext context, int mouseX, int mouseY, float deltaTicks) {
        context.fill(0, 0, this.width, this.height, BSOD_BLUE);

        int x = Math.max(18, this.width / 10);
        int y = Math.max(18, this.height / 8);
        int line = 14;

        draw(context, ":(", x, y, 4);
        y += 52;

        draw(context, "На вашем ПК возникла проблема, и его необходимо перезапустить.", x, y, 1);
        y += line;
        draw(context, "Мы просто собираем некоторые сведения об ошибке, а затем Minecraft вернётся.", x, y, 1);
        y += line * 2;
        draw(context, "0% завершено", x, y, 1);
        y += line * 2;
        draw(context, "Нажмите клавишу 0, чтобы всё стало обратно.", x, y, 1);
        y += line * 2;
        draw(context, "Код остановки: MINECRAFT_PRANK_EXCEPTION", x, y, 1);
        y += line;
        draw(context, "Файл: fabric_client_side_humor.sys", x, y, 1);
    }

    private void draw(DrawContext context, String text, int x, int y, int scale) {
        if (scale <= 1) {
            context.drawTextWithShadow(this.textRenderer, text, x, y, WHITE);
            return;
        }

        context.getMatrices().pushMatrix();
        context.getMatrices().scale(scale, scale);
        context.drawTextWithShadow(this.textRenderer, text, x / scale, y / scale, WHITE);
        context.getMatrices().popMatrix();
    }

    @Override
    public boolean keyPressed(KeyInput input) {
        if (input.key() == GLFW.GLFW_KEY_0 || input.key() == GLFW.GLFW_KEY_KP_0) {
            this.close();
            return true;
        }

        if (input.isEscape()) {
            return true;
        }

        return super.keyPressed(input);
    }

    @Override
    public boolean shouldCloseOnEsc() {
        return false;
    }

    @Override
    public boolean shouldPause() {
        return false;
    }

    @Override
    public void close() {
        MinecraftClient.getInstance().setScreen(null);
    }
}
