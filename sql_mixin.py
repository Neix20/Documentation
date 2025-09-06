from datetime import datetime, timezone

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import func

Base = declarative_base()


def current_utc_time():
    """Return the current UTC time with timezone."""
    return datetime.now().astimezone(timezone.utc)


class CRUDMixin:
    @staticmethod
    def create(session, model, **kwargs):
        """
        # TODO delete below comments
        kwargs sample
        {
            "conversation_id": 3,
            "analysis_dimension_name": "name_a",
            "analysis_dimension_score": "18/20",
            "analysis_dimension_text": "detail message a",
            "analysis_dimension_sequence": 1,
        }
        """
        with session() as session:
            try:
                instance = model(**kwargs)
                session.add(instance)
                session.commit()
                return instance.id
            except Exception as e:
                session.rollback()
                raise e
            finally:
                session.close()

    @staticmethod
    def batch_create(session, model, records):
        # batch create
        """
        # TODO delete below comments
        records sample
        [{
            "conversation_id": 3,
            "analysis_dimension_name": "name_a",
            "analysis_dimension_score": "18/20",
            "analysis_dimension_text": "detail message a",
            "analysis_dimension_sequence": 1,
        }， {
        ...
        }
        ]
        """
        with session() as session:
            try:
                instances = [model(**record) for record in records]
                session.bulk_save_objects(instances, return_defaults=True)
                session.commit()

                return [instance.id for instance in instances]
            except Exception as e:
                session.rollback()
                raise e
            finally:
                session.close()

    @staticmethod
    def read(session, model, filters, join_models=None):
        """
        Read records from the database with optional joins.

        session: SQLAlchemy session factory
        model: The model class to query
        filters: A dictionary of filters to apply
        join_models: A list of tuples specifying the join type, model to join, and join condition
                            Each tuple should be in the form (join_type, model, local_field, remote_field)
                            where join_type is 'inner' or 'left', model is the model to join,
                            local_field is the field on the main model, and remote_field is the field on the joined model
        return: List of query results
        """

        with session() as session:
            try:
                query = session.query(model)

                # Apply joins if specified
                if join_models:
                    for join_type, join_model, local_field, remote_field in join_models:
                        if join_type == 'inner':
                            query = query.join(join_model, local_field == remote_field)
                        elif join_type == 'left':
                            query = query.outerjoin(join_model, local_field == remote_field)

                # Apply filters
                for filter_model, sub_filters in filters.items():
                    for key, value in sub_filters.items():
                        if key == "or_condition":
                            # Handle OR condition
                            query = query.filter(value)
                        elif isinstance(value, list):
                            operator = value[0]
                            if operator == 'ne':  # not equals to
                                query = query.filter(getattr(filter_model, key) != value[1])
                            elif operator == 'between':
                                query = query.filter(getattr(filter_model, key).between(value[1], value[2]))
                            elif operator == 'like':
                                query = query.filter(func.lower(getattr(filter_model, key)).like(value[1].lower()))
                            elif operator == 'ilike':
                                # Handle 'ilike' condition
                                query = query.filter(getattr(filter_model, key).ilike(value[1]))
                            elif operator == 'gt':
                                query = query.filter(getattr(filter_model, key) > value[1])
                            elif operator == 'lt':  # less than
                                query = query.filter(getattr(filter_model, key) < value[1])
                            elif operator == 'ge':  # greater than or equals to
                                query = query.filter(getattr(filter_model, key) >= value[1])
                            elif operator == 'le':  # less than or equals to
                                query = query.filter(getattr(filter_model, key) <= value[1])
                            elif operator == 'null':
                                query = query.filter(getattr(filter_model, key).is_(None))
                            elif operator == 'not_null':
                                query = query.filter(getattr(filter_model, key).is_not(None))
                            elif operator == "in":
                                query = query.filter(getattr(filter_model, key).in_(value[1]))
                            elif operator == "ni":  # not in
                                query = query.filter(getattr(filter_model, key).notin_(value[1]))
                            else:  # invalid operator
                                raise TypeError(f"Unrecognized operator '{operator}'")
                        else:
                            # Handle 'equal' condition
                            query = query.filter(getattr(filter_model, key) == value)

                if join_models:
                    models = [model] + [item[1] for item in join_models]
                    query = query.with_entities(*models)

                # TODO delete below comments before deploy
                """
                using method -- join type: 
    
                calling:
                filters = {
                    GrpScenario: {
                        "id": scenario_id,
                        "flow_status": ["ne", "draft"]
                        "xxx": ["like", "%name%"]
                    },
                    GrpPersona: {
                        "by_default": True
                    }
                }
                join_models = [
                    ('left', GrpBusiness, GrpScenario.business_id, GrpBusiness.id),
                ]
                res = CRUDMixin.read(session, GrpScenario, filters, join_models=join_models)
    
                to get join select result:
                for model_1, model_2 in res:
                    print(model_1.id)
                    print(model_2.id)
                """
                return query.all()
            except Exception as e:
                session.rollback()
                raise e
            finally:
                session.close()

    @staticmethod
    def update(session, model, filters, **kwargs):
        # delete below comment before deploy uat
        """
        using sample

        filters = {
                "id": profile_id,
                "create_user": login_user.lower(),
                "deleted": 0,
            }

        update_kwarg = {
            "deleted": 1
        }

        res = CRUDMixin.update(session, GrpPersona, filters, **update_kwarg)

        res:
        [3, 4, 5, 6, 7, 8, 9, 10]  or None
        """

        with session() as session:
            try:
                query = session.query(model)
                for key, value in filters.items():
                    query = query.filter(getattr(model, key) == value)
                instances = query.all()
                if instances:
                    for instance in instances:
                        for key, value in kwargs.items():
                            setattr(instance, key, value)
                    session.commit()
                    return [instance.id for instance in instances]
                else:
                    return None
            except Exception as e:
                session.rollback()
                raise e
            finally:
                session.close()
    # all delete is update delete column
    # @staticmethod
    # def delete(session, model, filters):
    #     with session() as session:
    #         query = session.query(model)
    #         for key, value in filters.items():
    #             query = query.filter(getattr(model, key) == value)
    #         instance = query.first()
    #         if instance:
    #             session.delete(instance)
    #             session.commit()
    #             return instance.id
    #         else:
    #             return None

