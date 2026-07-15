export function localsMiddleware(req, res, next) {
    res.locals.errors = [];
    res.locals.success = [];
    res.locals.sessions = req.session || {};

    if(req.session.error) {
        res.locals.errors.push(req.session.error);
        delete req.session.error;
    }

    if(req.session.success) {
        res.locals.success.push(req.session.success);
        delete req.session.success;
    }

    next();
}