module MergeRequests
  class NoteService < ::MergeRequests::BaseService
    def execute(merge_request)
      execute_hooks(merge_request, 'note')

      merge_request
    end
  end
end
