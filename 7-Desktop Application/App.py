import tkinter 
from tkinter import ttk
from tkinter import *
from tkinter import messagebox 
import pyodbc
import tkinter as tk
from tkinter import StringVar


index=0
correct=0

def login():
    connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                            'Server=DESKTOP-DP443HJ;'
                            'Database=ITI Final;'
                            'Trusted_Connection=yes;')

# Creating a cursor object
    cursor = connection.cursor()

    code = ("SELECT * FROM student WHERE ST_Email = ? AND ST_PassWord = ?")
    cursor.execute(code , ((EntEmail.get()), Entpass.get()))
   
    reuslt = cursor.fetchall()
    connection.commit()
    connection.close()
   

    if reuslt:

        messagebox.showinfo('','Login worked Well ')
        frm.destroy()


        Course_frm = tk.Tk()
        Course_frm.geometry('500x500')
        Course_frm.iconbitmap('G:\ITI\BI-Data\Final Project\iti.ico')
        Course_frm.title( 'Course Page ')
        Ent_Crs_llb =ttk.Label(Course_frm, text='Course_ID',foreground='#57a1f8',background='white', font=('Arail',24,'bold'))
        Ent_Crs_llb.pack()

        Ent_Crs=IntVar()
        Ent_Crs=ttk.Entry(Course_frm,width=25,foreground='black' ,background= 'White' , font=('Arail',11),textvariable=Ent_Crs)
        Ent_Crs.pack()
        Ent_Crs.get()
        

        




        def Exam_Crs():
                
                
                root = tk.Tk()
                root.geometry('500x500')
                root.iconbitmap('G:\ITI\BI-Data\Final Project\iti.ico')
                root.title( 'Exam Page ')
                



                #QUE1()
                Entque1=ttk.Entry(root,width=70,foreground='black',background= 'White' , font=('Arail',15))
                Answer_1_Ent1 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_2_Ent1 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_3_Ent1 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_4_Ent1 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Correct_Answer_Ent1 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                                'Server=DESKTOP-DP443HJ;'
                                                'Database=ITI Final;'
                                                'Trusted_Connection=yes;')
                mycursor = connection.cursor()
                Q1=("select Top 1  Question   , Answer_1 , Answer_2 , Answer_3 ,Answer_4  ,Correct_Answer  FROM dbo.Question ORDER BY NEWID()")
                mycursor.execute(Q1)
                records = mycursor.fetchall()
                for  i ,  (Question , Answer_1 , Answer_2, Answer_3  , Answer_4 , Correct_Answer) in enumerate(records ,start=1):
                    Entque1.insert("", (Question))
                    Answer_1_Ent1.insert("",str(Answer_1))
                    Answer_2_Ent1.insert("",str(Answer_2) )
                    Answer_3_Ent1.insert("",str(Answer_3) )
                    Answer_4_Ent1.insert("",str(Answer_4) )
                    Correct_Answer_Ent1.insert("",str(Correct_Answer) )
                    connection.commit()

                #Que2
                Entque2=ttk.Entry(root,width=70,foreground='black',background= 'White' , font=('Arail',15))
                Answer_1_Ent2 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_2_Ent2 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_3_Ent2 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_4_Ent2 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Correct_Answer_Ent2 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                                'Server=DESKTOP-DP443HJ;'
                                                'Database=ITI Final;'
                                                'Trusted_Connection=yes;')
                mycursor = connection.cursor()
                Q2=(("select  Top 1  Question  , Answer_1 , Answer_2 , Answer_3 ,Answer_4  ,Correct_Answer  FROM dbo.Question ORDER BY NEWID()"))
                mycursor.execute(Q2)
                records2 = mycursor.fetchall()
                for  i ,  (Question2 , Answer_1_2 , Answer_2_2, Answer_3_2  , Answer_4_2 , Correct_Answer_2) in enumerate(records2 ,start=1):
                    Entque2.insert("", Question2)
                    Answer_1_Ent2.insert("",str(Answer_1_2))
                    Answer_2_Ent2.insert("",str(Answer_2_2) )
                    Answer_3_Ent2.insert("",str(Answer_3_2) )
                    Answer_4_Ent2.insert("",str(Answer_4_2) )
                    Correct_Answer_Ent2.insert("",str(Correct_Answer_2) )
                connection.commit()
                connection.close()

                #Que3
                Entque3=ttk.Entry(root,width=70,foreground='black',background= 'White' , font=('Arail',15))
                Answer_1_Ent3 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_2_Ent3 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_3_Ent3 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_4_Ent3 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Correct_Answer_Ent3 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                                'Server=DESKTOP-DP443HJ;'
                                                'Database=ITI Final;'
                                                'Trusted_Connection=yes;')
                mycursor = connection.cursor()
                Q3=(("select Top 1 Question  , Answer_1 , Answer_2 , Answer_3 ,Answer_4  ,Correct_Answer  FROM dbo.Question ORDER BY NEWID()"))
                mycursor.execute(Q3)
                records3 = mycursor.fetchall()
                for  i ,  (Question3 , Answer_1_3 , Answer_2_3, Answer_3_3  , Answer_4_3 , Correct_Answer_3) in enumerate(records3 ,start=1):
                    Entque3.insert("", Question3)
                    Answer_1_Ent3.insert("",str(Answer_1_3))
                    Answer_2_Ent3.insert("",str(Answer_2_3) )
                    Answer_3_Ent3.insert("",str(Answer_3_3) )
                    Answer_4_Ent3.insert("",str(Answer_4_3) )
                    Correct_Answer_Ent3.insert("",str(Correct_Answer_3) )
                connection.commit()
                connection.close()


                #Que4
                Entque4=ttk.Entry(root,width=70,foreground='black',background= 'White' , font=('Arail',15))
                Answer_1_Ent4 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_2_Ent4 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_3_Ent4 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_4_Ent4 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Correct_Answer_Ent4 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                                'Server=DESKTOP-DP443HJ;'
                                                'Database=ITI Final;'
                                                'Trusted_Connection=yes;')
                mycursor = connection.cursor()
                Q4=(("select Top 1 Question  , Answer_1 , Answer_2 , Answer_3 ,Answer_4  ,Correct_Answer  FROM dbo.Question ORDER BY NEWID()"))
                mycursor.execute(Q4)
                records4 = mycursor.fetchall()
                for  i ,  (Question4 , Answer_1_4 , Answer_2_4, Answer_3_4  , Answer_4_4 , Correct_Answer_4) in enumerate(records4 ,start=1):
                    Entque4.insert("", Question4)
                    Answer_1_Ent4.insert("",str(Answer_1_4))
                    Answer_2_Ent4.insert("",str(Answer_2_4) )
                    Answer_3_Ent4.insert("",str(Answer_3_4) )
                    Answer_4_Ent4.insert("",str(Answer_4_4) )
                    Correct_Answer_Ent4.insert("",str(Correct_Answer_4) )
                connection.commit()
                connection.close()

                
                #Que5
                Entque5=ttk.Entry(root,width=70,foreground='black',background= 'White' , font=('Arail',15))
                Answer_1_Ent5 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_2_Ent5 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_3_Ent5 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Answer_4_Ent5 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                Correct_Answer_Ent5 = ttk.Entry(root, width=50,foreground='black' ,background= 'White' ,font=('Arail', 15))
                connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                                'Server=DESKTOP-DP443HJ;'
                                                'Database=ITI Final;'
                                                'Trusted_Connection=yes;')
                mycursor = connection.cursor()
                Q5=(("select Top 1 Question  , Answer_1 , Answer_2 , Answer_3 ,Answer_4  ,Correct_Answer  FROM dbo.Question ORDER BY NEWID()"))
                mycursor.execute(Q5)
                records5 = mycursor.fetchall()
                for  i ,  (Question5 , Answer_1_5 , Answer_2_5, Answer_3_5  , Answer_4_5 , Correct_Answer_5) in enumerate(records5 ,start=1):
                    Entque5.insert("", Question5)
                    Answer_1_Ent5.insert("",str(Answer_1_5))
                    Answer_2_Ent5.insert("",str(Answer_2_5) )
                    Answer_3_Ent5.insert("",str(Answer_3_5) )
                    Answer_4_Ent5.insert("",str(Answer_4_5) )
                    Correct_Answer_Ent5.insert("",str(Correct_Answer_5) )
                connection.commit()
                connection.close()


                #ADD More Questions if you want 











                #Create Questions for the students

                questions = [Question,Question2,Question3,Question4,Question5]
                options = [[str(Answer_1),str(Answer_2),str(Answer_3),str(Answer_4),str(Correct_Answer)],
                        [str(Answer_1_2),str(Answer_2_2),str(Answer_3_2),str(Answer_4_2),Correct_Answer_2],
                        [str(Answer_1_3),str(Answer_2_3),str(Answer_3_3),str(Answer_4_3),Correct_Answer_3],
                        [str(Answer_1_4),str(Answer_2_4),str(Answer_3_4),str(Answer_4_4),Correct_Answer_4],
                        [str(Answer_1_5),str(Answer_2_5),str(Answer_3_5),str(Answer_4_5),Correct_Answer_5]]


                frame = tk.Frame(root, padx=10, pady=10,bg='#fff')
                question_label = tk.Label(frame,height=5, width=50,bg='grey',fg="#fff", 
                                        font=('Verdana', 20),wraplength=500)


                v1 = StringVar(frame)
                v2 = StringVar(frame)
                v3 = StringVar(frame)
                v4 = StringVar(frame)

                option1 = tk.Radiobutton(frame, bg="#fff", variable=v1, font=('Verdana', 20),
                                        command = lambda : checkAnswer(option1))
                option2 = tk.Radiobutton(frame, bg="#fff", variable=v2, font=('Verdana', 20), 
                                        command = lambda : checkAnswer(option2))
                option3 = tk.Radiobutton(frame, bg="#fff", variable=v3, font=('Verdana', 20), 
                                        command = lambda : checkAnswer(option3))
                option4 = tk.Radiobutton(frame, bg="#fff", variable=v4, font=('Verdana', 20), 
                                        command = lambda : checkAnswer(option4))

                button_next = tk.Button(frame, text='Next',bg='Orange', font=('Verdana', 20), 
                                        command = lambda : displayNextQuestion())

                frame.pack(fill="both", expand="true")
                question_label.grid(row=0, column=0)

                option1.grid(sticky= 'W', row=1, column=0)
                option2.grid(sticky= 'W', row=2, column=0)
                option3.grid(sticky= 'W', row=3, column=0)
                option4.grid(sticky= 'W', row=4, column=0)

                button_next.grid(row=6, column=0)


                global index 
                global correct 

                # create a function to disable radiobuttons
                def disableButtons(state):
                    option1['state'] = state
                    option2['state'] = state
                    option3['state'] = state
                    option4['state'] = state


                # create a function to check the selected answer
                def checkAnswer(radio):
                    global correct, index
                    
                    # the 4th item is the correct answer
                    # we will check the user selected answer with the 4th item
                    if radio['text'] == options[index][4]:
                        correct +=1

                    index +=1
                    disableButtons('disable')


                # create a function to display the next question
                def displayNextQuestion():
                    global index, correct

                    if button_next['text'] == 'Restart The Quiz':
                        correct = 0
                        index = 0
                        question_label['bg'] = 'grey'
                        button_next['text'] = 'Next'

                    if index == len(options):
                        question_label['text'] = str(correct) + " / " + str(len(options))
                        button_next['text'] = 'Restart The Quiz'
                        connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                                'Server=DESKTOP-DP443HJ;'
                                                'Database=ITI Final;'
                                                'Trusted_Connection=yes;')

                    # Creating a cursor object
                        cursor = connection.cursor()
                        Update = ("UPDATE grade SET Grade = ?  FROM grade JOIN Student ON grade.ST_ID = Student.ST_ID WHERE Student.ST_Email = ? and [Crs_ID] = ? "  )
                        cursor.execute(Update , ((correct/len(options))*100 ), Email , Ent_Crs.get() )
                        connection.commit()
                        connection.close()
                        if correct >= len(options)/2:
                            question_label['bg'] = 'green'
                        else:
                                question_label['bg'] = 'red'





                    else:
                            question_label['text'] = questions[index]
                            disableButtons('normal')
                            opts = options[index]
                            option1['text'] = opts[0]
                            option2['text'] = opts[1]
                            option3['text'] = opts[2]
                            option4['text'] = opts[3]
                            v1.set(opts[0])
                            v2.set(opts[1])
                            v3.set(opts[2])
                            v4.set(opts[3])

                            if index == len(options) - 1:
                                button_next['text'] = 'Check the Results'





                displayNextQuestion()

                root.mainloop()
                

        bt_Crs=Button(Course_frm , text = 'Enter' , command=lambda: [Exam_Crs()]).pack(pady=10)
        
        Course_frm.mainloop
        

        return True
    else:

        messagebox.showinfo('','Please Enter a vaild Email or Password')
        
        return False
    
    
            
    

        
        




frm=tkinter.Tk()
frm.title(' Exam Login')
frm.geometry('925x500+300+300')

frm.iconbitmap('G:\ITI\BI-Data\Final Project\iti.ico')
frm.config(background= '#FFF')
img=PhotoImage(file='download 2.png')
Label(frm,image=img,bg='white').place(x=50,y=50)
fram=Frame(frm,width=350,height=350,bg='white')
fram.place(x=480,y=70)

llb =ttk.Label(fram, text='Sign In',foreground='#57a1f8',background='white', font=('Arail',24,'bold'))
llb.place(x=100,y=5)

Svemail=StringVar()
EntEmail=ttk.Entry(fram,width=25,foreground='black' ,background= 'White' , font=('Arail',11),textvariable=Svemail)
EntEmail.place(x=30,y=80)
EntEmail.insert(0,'Abdelhak.Boukortt73@gmail.com')
Frame(fram,width=295,height=2,background='black').place(x=25,y=107)
Entpass=ttk.Entry(fram,width=25,foreground='black' , background= 'White' , font=('Arail',11))#,textvariable=SvPass )
Entpass.place(x=30,y=150)
Entpass.insert(0,'7019729139')
Email=EntEmail.get()
Pass=Entpass.get()


Frame(fram,width=295,height=2,background='black').place(x=25,y=177)

Button(fram,width=39,pady=7,background='#57a1f8',foreground='White',text='Sign In',border=0,command=lambda: [login()]).place(x=35,y=204)

frm.mainloop()

