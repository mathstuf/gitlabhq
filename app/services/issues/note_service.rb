module Issues
  class NoteService < Issues::BaseService
    def execute(issue)
      execute_hooks(issue, 'note')

      issue
    end
  end
end
