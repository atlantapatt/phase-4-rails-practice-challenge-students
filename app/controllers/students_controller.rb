class StudentsController < ApplicationController

    def index
        student = Student.all
        render json: student, status: :ok
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student, status: :ok
        else
            not_found
        end
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            unprocessable_entity(student)
        end
    end

    def update
        student = Student.find_by(id: params[:id])
        if student
            student.update(student_params)
            render json: student, status: :ok
        else
            not_found
        end
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            not_found
        end
    end

    private

    def student_params
        params.permit(:name, :major, :age, :student_id)
    end

    def unprocessable_entity(invalid)
        render json: {error: invalid.errors}, status: :unprocessable_entity
    end

    def not_found
        render json: {error: "Student not found"}, status: :not_found
    end
end
