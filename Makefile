PWD=$(shell pwd)
ROLE_NAME=franklinkim.newrelic
ROLE_PATH=/etc/ansible/roles/$(ROLE_NAME)
TEST_VERSION=ansible --version
TEST_SYNTAX=ansible-playbook -v -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml --syntax-check
TEST_PLAYBOOK=ansible-playbook -vvvv -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml
TEST_CMD=$(TEST_VERSION); $(TEST_SYNTAX); $(TEST_PLAYBOOK); $(TEST_PLAYBOOK)

test_ubuntu16.04: dist=ubuntu-16.04
test_ubuntu16.04: test

test_ubuntu14.04: dist=ubuntu-14.04
test_ubuntu14.04: test

test_debian9: dist=debian-9
test_debian9: test

test_debian8: dist=debian-8
test_debian8: test

test_centos7: dist=el-7
test_centos7: test

test:
	docker run -it --rm -v $(PWD):$(ROLE_PATH) ansiblecheck/ansiblecheck:$(dist) /bin/bash -c "$(TEST_CMD)"
