package game;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.Color;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.swing.JTextField;
import javax.swing.JPasswordField;
import javax.swing.JCheckBox;
import javax.swing.JButton;
import javax.swing.ImageIcon;

public class login extends JFrame {

	private JPanel contentPane;
	private JTextField textField;
	private JPasswordField passwordField;

	Connection con;
	Statement stm;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					login frame = new login();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public login() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(500, 200, 415, 300);
		contentPane = new JPanel();
		contentPane.setBackground(Color.BLACK);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		contentPane.setLayout(null);

		JCheckBox chckbxNewCheckBox = new JCheckBox("");
		chckbxNewCheckBox.setBackground(Color.MAGENTA);
		chckbxNewCheckBox.setBounds(231, 142, 21, 20);
		chckbxNewCheckBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (chckbxNewCheckBox.isSelected()) {
					// Show password
					passwordField.setEchoChar('\u0000');
				} else {
					// Hide password
					passwordField.setEchoChar('*');
				}
			}
		});
		contentPane.add(chckbxNewCheckBox);

		JLabel lblNewLabel = new JLabel("MATCHING |2k23| GAME");
		lblNewLabel.setForeground(Color.MAGENTA);
		lblNewLabel.setFont(new Font("Gill Sans MT Ext Condensed Bold", Font.PLAIN, 35));
		lblNewLabel.setBounds(109, 11, 221, 34);
		contentPane.add(lblNewLabel);

		textField = new JTextField();
		textField.setBounds(155, 85, 97, 20);
		contentPane.add(textField);
		textField.setColumns(10);

		passwordField = new JPasswordField();
		passwordField.setEchoChar('*');
		passwordField.setBounds(155, 142, 78, 20);
		contentPane.add(passwordField);

		JLabel lblNewLabel_1 = new JLabel("Username");
		lblNewLabel_1.setForeground(Color.MAGENTA);
		lblNewLabel_1.setBounds(155, 69, 78, 14);
		contentPane.add(lblNewLabel_1);

		JLabel lblNewLabel_1_1 = new JLabel("Password");
		lblNewLabel_1_1.setForeground(Color.MAGENTA);
		lblNewLabel_1_1.setBounds(155, 127, 78, 14);
		contentPane.add(lblNewLabel_1_1);

		JButton btnNewButton = new JButton("LOGIN\r\n\r\n");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String user = textField.getText();
				String password = (String) passwordField.getText();
				
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost/jbms", "root", "");
					stm = con.createStatement();
					ResultSet rs = stm.executeQuery("select username,password from account");
					while (rs.next()) {
						String username = rs.getString(1);
						String passwordString = rs.getString(2);

						if (user.equals(username) && password.equals(passwordString) ) {
							MainFrame.main(null);
							dispose();
						} else {
							wrongInput.main(null);
						}

					}
					con.close();
				} catch (Exception ev) {
					ev.printStackTrace();
				}

			}
		});
		btnNewButton.setBounds(163, 191, 78, 23);
		contentPane.add(btnNewButton);

		JButton btnNewButton_1 = new JButton("EXIT");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		btnNewButton_1.setBackground(Color.WHITE);
		btnNewButton_1.setFont(new Font("Tahoma", Font.BOLD, 20));
		btnNewButton_1.setBounds(300, 227, 89, 23);
		contentPane.add(btnNewButton_1);
	}
	
}
