"""Ansible jinja2 filters."""

def format_list(list_, pattern):
    """Format a list of strings using a pattern."""
    newlist = []
    for s in list_:
        newlist.append(pattern.format(int(s)))
    return newlist
    #return [pattern % int(s) for s in list_]


class FilterModule(object):
    """Ansible jinja2 filters."""
    def filters(self):
        return {
            'format_list': format_list,
        }
