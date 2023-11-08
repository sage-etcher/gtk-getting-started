#include <gtk/gtk.h>


/* local function prototypes */
static void print_hello (GtkWidget *widget, gpointer data);
static void activate    (GtkApplication *app, gpointer user_data);


/* main program-entry-point */
int
main (int    argc,
      char **argv)
{
        GtkApplication *app;
        int status;

        app = gtk_application_new ("org.gtk.example", G_APPLICATION_DEFAULT_FLAGS);
        g_signal_connect (app, "activate", G_CALLBACK (activate), NULL);
        status = g_application_run (G_APPLICATION (app), argc, argv);
        g_object_unref (app);

        return (status);
}


/* function definitions */
static void
print_hello (GtkWidget *widget,
             gpointer   data)
{
        g_print ("Hello, World!\n");
}


static void
activate (GtkApplication *app,
          gpointer        user_data)
{
        GtkWidget *window;
        GtkWidget *button;

        window = gtk_application_window_new (app);
        gtk_window_set_title (GTK_WINDOW (window), "Window");
        gtk_window_set_default_size (GTK_WINDOW (window), 200, 200);

        button = gtk_button_new_with_label ("Message");
        g_signal_connect (button, "clicked", G_CALLBACK (print_hello), NULL);
        gtk_window_set_child (GTK_WINDOW (window), button);

        gtk_window_present (GTK_WINDOW (window));
}


/* end of file */
