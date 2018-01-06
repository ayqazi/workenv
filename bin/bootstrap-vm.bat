ECHO 'Bring up a VM and fully provision it for the first time. Not designed for subsequent reprovisions'
vagrant up && vagrant reload --provision && vagrant reload
