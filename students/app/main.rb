require_relative './student_list_view/student_list_view.rb'

app = FXApp.new
StudentListView.new(app)
app.create()
app.run()