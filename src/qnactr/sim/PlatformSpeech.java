package qnactr.sim;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** Plays model speech through an installed operating-system speech synthesizer. */
final class PlatformSpeech {
    private static final ExecutorService SPEECH_QUEUE = Executors.newSingleThreadExecutor(task -> {
        Thread thread = new Thread(task, "qn-actr-speech");
        thread.setDaemon(true);
        return thread;
    });
    private static volatile boolean unavailableReported;

    private PlatformSpeech() {
    }

    static void speak(String text) {
        if (text == null || text.isBlank()) {
            return;
        }
        SPEECH_QUEUE.execute(() -> play(text));
    }

    private static void play(String text) {
        String os = System.getProperty("os.name", "").toLowerCase(Locale.ROOT);
        boolean windows = os.startsWith("windows");
        String spokenText = os.startsWith("linux") ? "hum... " + text : text;
        List<List<String>> commands = new ArrayList<>();
        if (windows) {
            // Read speech from stdin so punctuation is never interpreted as PowerShell code.
            commands.add(List.of("powershell.exe", "-NoProfile", "-NonInteractive", "-Command",
                    "Add-Type -AssemblyName System.Speech; $voice = New-Object System.Speech.Synthesis.SpeechSynthesizer; $voice.Speak([Console]::In.ReadToEnd())"));
        } else if (os.startsWith("mac") || os.startsWith("darwin")) {
            commands.add(List.of("say", text));
        } else {
            commands.add(List.of("espeak-ng", spokenText));
            commands.add(List.of("espeak", spokenText));
            commands.add(List.of("spd-say", "--wait", spokenText));
        }

        for (List<String> command : commands) {
            try {
                Process process = new ProcessBuilder(command)
                        .redirectOutput(ProcessBuilder.Redirect.DISCARD)
                        .redirectError(ProcessBuilder.Redirect.DISCARD)
                        .start();
                if (windows) {
                    process.getOutputStream().write(text.getBytes(StandardCharsets.UTF_8));
                }
                process.getOutputStream().close();
                if (process.waitFor() == 0) {
                    return;
                }
            } catch (IOException e) {
                // Try the next installed synthesizer.
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return;
            }
        }
        if (!unavailableReported) {
            unavailableReported = true;
            System.err.println("QN-ACTR speech playback unavailable: no working system TTS command found.");
        }
    }
}
