
namespace WFormsUserApp
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.richTextBox2 = new System.Windows.Forms.RichTextBox();
            this.sensor1 = new System.Windows.Forms.Button();
            this.sensor2 = new System.Windows.Forms.Button();
            this.sensor3 = new System.Windows.Forms.Button();
            this.richTextBox3 = new System.Windows.Forms.RichTextBox();
            this.FCM_Timer = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // richTextBox1
            // 
            this.richTextBox1.Location = new System.Drawing.Point(9, 72);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.Size = new System.Drawing.Size(296, 366);
            this.richTextBox1.TabIndex = 2;
            this.richTextBox1.Text = "";
            // 
            // richTextBox2
            // 
            this.richTextBox2.Location = new System.Drawing.Point(311, 72);
            this.richTextBox2.Name = "richTextBox2";
            this.richTextBox2.Size = new System.Drawing.Size(408, 366);
            this.richTextBox2.TabIndex = 3;
            this.richTextBox2.Text = "";
            // 
            // sensor1
            // 
            this.sensor1.Location = new System.Drawing.Point(12, 22);
            this.sensor1.Name = "sensor1";
            this.sensor1.Size = new System.Drawing.Size(75, 23);
            this.sensor1.TabIndex = 4;
            this.sensor1.Text = "sensor1";
            this.sensor1.UseVisualStyleBackColor = true;
            // 
            // sensor2
            // 
            this.sensor2.Location = new System.Drawing.Point(105, 22);
            this.sensor2.Name = "sensor2";
            this.sensor2.Size = new System.Drawing.Size(75, 23);
            this.sensor2.TabIndex = 5;
            this.sensor2.Text = "sensor2";
            this.sensor2.UseVisualStyleBackColor = true;
            // 
            // sensor3
            // 
            this.sensor3.Location = new System.Drawing.Point(206, 22);
            this.sensor3.Name = "sensor3";
            this.sensor3.Size = new System.Drawing.Size(75, 23);
            this.sensor3.TabIndex = 6;
            this.sensor3.Text = "sensor3";
            this.sensor3.UseVisualStyleBackColor = true;
            // 
            // richTextBox3
            // 
            this.richTextBox3.Location = new System.Drawing.Point(724, 72);
            this.richTextBox3.Name = "richTextBox3";
            this.richTextBox3.Size = new System.Drawing.Size(296, 366);
            this.richTextBox3.TabIndex = 8;
            this.richTextBox3.Text = "";
            // 
            // FCM_Timer
            // 
            this.FCM_Timer.Tick += new System.EventHandler(this.FCM_Timer_Tick);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1027, 460);
            this.Controls.Add(this.richTextBox3);
            this.Controls.Add(this.sensor3);
            this.Controls.Add(this.sensor2);
            this.Controls.Add(this.sensor1);
            this.Controls.Add(this.richTextBox2);
            this.Controls.Add(this.richTextBox1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);

        }

        #endregion
        internal System.Windows.Forms.RichTextBox richTextBox1;
        internal System.Windows.Forms.RichTextBox richTextBox2;
        private System.Windows.Forms.Button sensor1;
        private System.Windows.Forms.Button sensor2;
        private System.Windows.Forms.Button sensor3;
        internal System.Windows.Forms.RichTextBox richTextBox3;
        private System.Windows.Forms.Timer FCM_Timer;
    }
}

