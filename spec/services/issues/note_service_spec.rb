require 'spec_helper'

describe Issues::NoteService do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:issue) { create(:issue) }
  let(:project) { issue.project }

  before do
    project.team << [user, :master]
    project.team << [user2, :developer]
  end

  describe :execute do
    context 'valid params' do
      let(:service) { Issues::NoteService.new(project, user, {}) }

      before do
        allow(service).to receive(:execute_hooks)

        @issue = service.execute(issue)
      end

      it 'should execute hooks with note action' do
        expect(service).to have_received(:execute_hooks).
                               with(@issue, 'note')
      end
    end
  end
end
