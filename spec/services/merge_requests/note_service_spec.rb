require 'spec_helper'

describe MergeRequests::NoteService do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:merge_request) { create(:merge_request, assignee: user2) }
  let(:project) { merge_request.project }

  before do
    project.team << [user, :master]
    project.team << [user2, :developer]
  end

  describe :execute do
    context 'valid params' do
      let(:service) { MergeRequests::NoteService.new(project, user, {}) }

      before do
        allow(service).to receive(:execute_hooks)

        @merge_request = service.execute(merge_request)
      end

      it 'should execute hooks with note action' do
        expect(service).to have_received(:execute_hooks).
                               with(@merge_request, 'note')
      end
    end
  end
end
