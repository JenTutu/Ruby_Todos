require_relative 'todo'

describe 'Tasks' do 
  let (:task) {Tasks.new("Help mom with dishes.")}

  it 'should have a #complete? attribute' do
    expect(task.complete?).to be_false
  end

  it 'should return true when #mark_completed' do
    expect(task.mark_completed).to be_true
  end 

  it 'should return true for #complete? when #mark_completed' do
    task.mark_completed
    expect(task.complete?).to be_true
  end
end