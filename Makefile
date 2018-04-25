PWD=$(shell pwd)
ROLE_NAME=franklinkim.newrelic
ROLE_PATH=/etc/ansible/roles/$(ROLE_NAME)
TEST_VERSION=ansible --version
TEST_DEPS=ansible-galaxy install weareinteractive.apt franklinkim.openssl franklinkim.htpasswd
TEST_SYNTAX=ansible-playbook -v -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml --syntax-check
TEST_PLAYBOOK=ansible-playbook -vvvv -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml
TEST_CMD=$(TEST_DEPS); $(TEST_VERSION); $(TEST_SYNTAX); $(TEST_PLAYBOOK)

test_ubuntu16.06: dist=ubuntu16.06
test_ubuntu16.06: test

test_ubuntu14.06: dist=ubuntu14.06
test_ubuntu14.06: test

test_debian9: dist=debian9
test_debian9: test

test_debian8: dist=debian8
test_debian8: test

test_centos7: dist=centos7
test_centos7: test

test:
	docker run -it --rm -v $(PWD):$(ROLE_PATH) williamyeh/ansible:$(dist) /bin/bash -c "$(TEST_CMD)"
